class Legals::TermsOfServicesController < ApplicationController
  skip_before_action :authenticate_user!
  def show
  end
end
