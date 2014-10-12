module Concerns

  module Crud
    extend ActiveSupport::Concern

    included do

      def index
        @search = search_class.search(params)
        @collection = PaginatedCollectionDecorator.decorate(@search.perform)
      end

      def show
      end

      def new
        @resource = resource_class.new
      end

      def create
        @resource = resource_class.new(resource_params)

        before_create

        if resource.save
          flash[:success] = I18n.t("flash.#{singular_name}.create.success")
          redirect_to url_after_create
        else
          flash[:warning] = I18n.t("flash.#{singular_name}.create.failure")
          render :new
        end
      end

      def update
        if resource.update_attributes(resource_params)
          flash[:success] = I18n.t("flash.#{singular_name}.update.success")
          redirect_to url_after_update
        else
          flash[:danger] = I18n.t("flash.#{singular_name}.update.failure")
          render :edit
        end
      end

      def destroy
        if resource.destroy
          flash[:success] = I18n.t("flash.#{singular_name}.destroy.success")
          redirect_to url_after_destroy
        else
          flash[:danger] = I18n.t(
            "flash.#{singular_name}.destroy.failure",
            errors: resource.errors.full_messages.to_sentence
          )
          redirect_to url_after_destroy_failure
        end
      end


      private


      def url_after_create
        namespace << resource
      end

      def url_after_update
        namespace << resource
      end

      def url_after_destroy
        namespace << plural_name
      end

      def url_after_destroy_failure
        namespace << resource
      end

      def before_create
      end

      def namespace
        []
      end

      def resource
        @resource ||= collection.find(params[:id]).decorate
      end

      def singular_name
        @singular_name ||= resource_class.name.underscore.downcase
      end

      def plural_name
        @plural_name ||= singular_name.pluralize
      end

      def resource_class
        self.class.name.split('::').last.gsub('Controller', '').singularize.constantize
      end

      def collection
        @collection ||= scope.send(plural_name)
      end

      def search_class
      end

      def resource_params
      end

    end
  end

end

