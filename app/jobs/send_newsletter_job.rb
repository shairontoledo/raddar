class SendNewsletterJob < Struct.new(:newsletter_id)
  include Rails.application.routes.url_helpers
  
  def perform
    begin
      newsletter = Newsletter.find newsletter_id
      
      User.all.each do |user|
        if user.active?
          NewsletterMailer.newsletter_mail(newsletter, user).deliver 
        end
      end
    rescue Mongoid::Errors::DocumentNotFound
    end
  end
end