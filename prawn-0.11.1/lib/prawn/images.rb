# encoding: ASCII-8BIT
# images.rb : Implements PDF image embedding
#
# Copyright April 2008, James Healy, Gregory Brown.  All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

require 'digest/sha1'

module Prawn

  module Images

    # Add the image at filename to the current page. Currently only
    # JPG and PNG files are supported.
    #
    # NOTE: Prawn is very slow at rendering PNGs with alpha channels.  The
    # workaround for those who don't mind installing RMagick is to use:
    #
    # http://github.com/amberbit/prawn-fast-png
    #
    # Arguments:
    # <tt>file</tt>:: path to file or an object that responds to #read
    #
    # Options:
    # <tt>:at</tt>:: an array [x,y] with the location of the top left corner of the image.
    # <tt>:position</tt>::  One of (:left, :center, :right) or an x-offset
    # <tt>:vposition</tt>::  One of (:top, :center, :center) or an y-offset    
    # <tt>:height</tt>:: the height of the image [actual height of the image]
    # <tt>:width</tt>:: the width of the image [actual width of the image]
    # <tt>:scale</tt>:: scale the dimensions of the image proportionally
    # <tt>:fit</tt>:: scale the dimensions of the image proportionally to fit inside [width,height]
    # 
    #   Prawn::Document.generate("image2.pdf", :page_layout => :landscape) do     
    #     pigs = "#{Prawn::BASEDIR}/data/images/pigs.jpg" 
    #     image pigs, :at => [50,450], :width => 450                                      
    #
    #     dice = "#{Prawn::BASEDIR}/data/images/dice.png"
    #     image dice, :at => [50, 450], :scale => 0.75 
    #   end   
    #
    # If only one of :width / :height are provided, the image will be scaled
    # proportionally.  When both are provided, the image will be stretched to 
    # fit the dimensions without maintaining the aspect ratio.
    #
    #
    # If :at is provided, the image will be place in the current page but
    # the text position will not be changed.
    #
    #
    # If instead of an explicit filename, an object with a read method is
    # passed as +file+, you can embed images from IO objects and things
    # that act like them (including Tempfiles and open-uri objects).
    #
    #   require "open-uri"
    #
    #   Prawn::Document.generate("remote_images.pdf") do 
    #     image open("http://prawn.majesticseacreature.com/media/prawn_logo.png")
    #   end
    #
    # This method returns an image info object which can be used to check the
    # dimensions of an image object if needed. 
    # (See also: Prawn::Images::PNG , Prawn::Images::JPG)
    # 
    def image(file, options={})
      Prawn.verify_options [:at, :position, :vposition, :height, 
                            :width, :scale, :fit], options

      if file.respond_to?(:read)
        image_content = file.read
      else
        raise ArgumentError, "#{file} not found" unless File.file?(file)  
        image_content = File.binread(file)
      end
      
      image_sha1 = Digest::SHA1.hexdigest(image_content)

      # if this image has already been embedded, just reuse it
      if image_registry[image_sha1]
        info = image_registry[image_sha1][:info]
        image_obj = image_registry[image_sha1][:obj]
      else
        # Build the image object
        klass = case detect_image_format(image_content)
                when :jpg then Prawn::Images::JPG
                when :png then Prawn::Images::PNG
                end
        info = klass.new(image_content)

        # Bump PDF version if the image requires it
        min_version(info.min_pdf_version) if info.respond_to?(:min_pdf_version)

        # Add the image to the PDF and register it in case we see it again.
        image_obj = info.build_pdf_object(self)
        image_registry[image_sha1] = {:obj => image_obj, :info => info}
      end

      # find where the image will be placed and how big it will be  
      w,h = calc_image_dimensions(info, options)

      if options[:at]     
        x,y = map_to_absolute(options[:at]) 
      else                  
        x,y = image_position(w,h,options) 
        move_text_position h   
      end

      # add a reference to the image object to the current page
      # resource list and give it a label
      label = "I#{next_image_id}"
      state.page.xobjects.merge!( label => image_obj )

      # add the image to the current page
      instruct = "\nq\n%.3f 0 0 %.3f %.3f %.3f cm\n/%s Do\nQ"
      add_content instruct % [ w, h, x, y - h, label ]
      
      return info
    end

    private   
    
    def image_position(w,h,options)
      options[:position] ||= :left
      
      x = case options[:position] 
      when :left
        bounds.absolute_left
      when :center
        bounds.absolute_left + (bounds.width - w) / 2.0 
      when :right
        bounds.absolute_right - w
      when Numeric
        options[:position] + bounds.absolute_left
      end

      y = case options[:vposition]
      when :top
        bounds.absolute_top
      when :center
        bounds.absolute_top - (bounds.height - h) / 2.0
      when :bottom
        bounds.absolute_bottom + h
      when Numeric
        bounds.absolute_top - options[:vposition]
      else
        determine_y_with_page_flow(h)
      end
      return [x,y]
    end 
    
    def determine_y_with_page_flow(h)
      if overruns_page?(h)
        start_new_page
        bounds.absolute_top 
      else
        self.y
      end
    end 
    
    def overruns_page?(h)
      (self.y - h) < bounds.absolute_bottom 
    end

    def calc_image_dimensions(info, options)
      w = options[:width] || info.width
      h = options[:height] || info.height

      if options[:width] && !options[:height]
        wp = w / info.width.to_f 
        w = info.width * wp
        h = info.height * wp
      elsif options[:height] && !options[:width]         
        hp = h / info.height.to_f
        w = info.width * hp
        h = info.height * hp   
      elsif options[:scale] 
        w = info.width * options[:scale]
        h = info.height * options[:scale]
      elsif options[:fit] 
        bw, bh = options[:fit]
        bp = bw / bh.to_f
        ip = info.width / info.height.to_f
        if ip > bp
          w = bw
          h = bw / ip
        else
          h = bh
          w = bh * ip
        end
      end
      info.scaled_width = w
      info.scaled_height = h
      [w,h]
    end

    def detect_image_format(content)
      top = content[0,128]                       

      # Unpack before comparing for JPG header, so as to avoid having to worry
      # about the source string encoding. We just want a byte-by-byte compare.
      if top[0, 3].unpack("C*") == [255, 216, 255]
        return :jpg
      elsif top[0, 8].unpack("C*") == [137, 80, 78, 71, 13, 10, 26, 10]
        return :png
      else
        raise Errors::UnsupportedImageType, "image file is an unrecognised format"
      end
    end

    def image_registry
      @image_registry ||= {}
    end

    def next_image_id
      @image_counter ||= 0
      @image_counter += 1
    end
  end
end