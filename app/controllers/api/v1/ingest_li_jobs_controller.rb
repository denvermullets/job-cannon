module Api
  module V1
    class IngestLiJobsController < ApplicationController
      def index
        Scrape::LiLogin.call

        render json: { message: 'all pages loaded!' }
      end
    end
  end
end
