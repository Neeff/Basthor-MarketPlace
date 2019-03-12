ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :email, :password, :role, :address, :name, :password_confirmation
controller do
        def update
          if (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
            params[:user].delete("password")
            params[:user].delete("password_confirmation")
          end
          super
        end
      end

index do
        column :id
        column :email
        column :created_at
        column :address
        actions
        end

        form do |f|
                inputs 'Agregar un nuevo usuario' do
                input :email
                input :password
                input :address
                input :name
                input :role
                end
                actions
               end

               filter :email

end
