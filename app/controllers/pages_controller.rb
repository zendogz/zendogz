class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.all.to_a
  end

  def about
  end

  def services
  end

  def contact
    puts "!!!send: #{params[:message]}!!!" if params[:message].present?
  end

  def gallery
  end
end
