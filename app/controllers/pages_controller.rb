class PagesController < ApplicationController
  def home
    @testimonials = Testimonial.all.to_a
  end

  def about
  end

  def services
  end

  def contact
  end

  def gallery
  end
end
