require "rails/generators/erb"
require "rails/generators/resource_helpers"

module Erb # :nodoc:
  module Generators # :nodoc:
    class ScaffoldGenerator < Base # :nodoc:
      include Rails::Generators::ResourceHelpers

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_root_folder
        empty_directory File.join("app/javascript/views", controller_file_path)
        # empty_directory File.join("config/locales/resources", controller_file_path)
      end

      def copy_view_files
        # Generate html.erb and js.erb files
        available_views.each do |view|
          [:vue].each do |format|
            filename = filename_with_extensions(view, format)
            template filename.gsub(".erb", ""), File.join("app/javascript/views", controller_file_path, filename.gsub(".erb", ""))
          end
        end

        # # Generate translation for all defined languages
        # I18n.available_locales.each do |language|
        #   @language = language
        #   filename = filename_with_extensions(controller_file_path, "#{language}.yml")
        #   template 'translation.yml', File.join("config/locales/resources", controller_file_path, filename.gsub(".erb", "")), language
        # end
      end

    private

      def available_views
        %w(index edit show new form)
      end
    end
  end
end
