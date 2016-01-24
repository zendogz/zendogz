class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.all.to_a
  end

  def about
  end

  def services
  end

  def contact
    if params[:message].present?
      ContactMailer.contact_message(params[:message], params[:email]).deliver_now
      flash[:success] = 'message sent successfully.'
    end
  end

  def gallery
  end
end
