class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.all.to_a
    @gallery_indexes = (1..65).to_a.shuffle
  end

  def about
  end

  def services
  end

  def contact
    if params[:message].present?
      ContactMailer.contact_message(params[:message], params[:email]).deliver_now
      flash[:notice] = 'message sent successfully.'
    end
  end

  def gallery
    @gallery_indexes = (1..66).to_a.shuffle
    @gallery_captions = YAML.load_file("#{Rails.root.to_s}/config/gallery_captions.yml")
  end
end
