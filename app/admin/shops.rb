ActiveAdmin.register Shop do
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
permit_params :name, :description, :user_id

filter :name
csv do
  column :email do |shop|
    shop.user.email
  end
  column :amount do |shop|
    orders = shop.orders.where(paid: true).where(dispached: true).where('created_at >= :month', month: Time.now - 30.days).map{|order| order.quantity * order.price}.sum 
  end
  column :currency do
    'USD'
  end
  column :id
  column :note do
    'payment'
  end

end




show do
    attributes_table do
      row :name
      row :user_id
      row :created_at
      row :updated_at
    end
    attributes_table do
       span "#{Shop.find(params[:id])} "
    end  
end

end
