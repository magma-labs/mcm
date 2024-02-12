# frozen_string_literal: true

module Mcm
  module Admin
    class LocalesController < BaseController
      include Mcm::Admin::LocalesHelper

      before_action :find_locale, except: [:new, :create]

      def new
        @locale = model_class.new locale_params
      end

      def create
        @locale = model_class.create! locale_params
        redirect_to localizable_path
      end

      def edit
      end

      def update
        @locale.update! locale_params
        redirect_to localizable_path
      end

      def destroy
        @locale.destroy
        redirect_back fallback_location: localizable_path
      end

      private

      def find_locale
        @locale = model_class.find(params[:id])
      end

      def locale_params
        params.require(:mcm_locale).permit :locale, :key, :value, :localizable_id, :localizable_type
      end

      def model_class
        Mcm::Locale
      end
    end
  end
end
