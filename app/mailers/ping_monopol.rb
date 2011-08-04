class PingMonopol < ActionMailer::Base
  default :from => "order_updates@daapparel.com"
  
  def ping_mono(collection)
    @collection = collection
    @folder = Collection.find(@collection).collector
    @style = Collection.find(@collection).collected
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "A Purchase Order needs Monopol's review"
    )
  end
  
  def ping_daa(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "A Purchase Order has been updated for DAA"
    )
  end
  
  def agreed(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Purchase Order agreed to, ready for pre-production"
    )
  end
  
  def approved(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Purchase Order production approval"
    )
  end
  
  def shipped(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Purchase Order has shipped"
    )
  end
  
  def delivered(collection)
    @collection = collection
    mail(
      :to => "lyndseyearnold@gmail.com",
      :cc => "ryan.armbrust@gmail.com",
      :subject => "Purchase Order has been delivered"
    )
  end
end
