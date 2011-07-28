class PingMonopol < ActionMailer::Base
  default :from => "order_updates@daapparel.com"
  
  def ping_mono(collection)
    @collection = collection
    @folder = Collection.find(@collection).collector
    @style = Collection.find(@collection).collected
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Linesheet Needs Monopol's Review - Test"
    )
  end
  
  def ping_daa(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Linesheet Needs DAA's Review - Test"
    )
  end
  
  def agreed(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Linesheet Agreement - Test"
    )
  end
  
  def approved(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Production Approval - Test"
    )
  end
  
  def shipped(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Production as Shipped - Test"
    )
  end
  
  def delivered(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Production is Delivered - Test"
    )
  end
end
