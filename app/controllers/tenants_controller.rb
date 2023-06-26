class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

    def create 
        tenant = Tenant.create(tenant_params)
        render json: tenant, status: :created
    end 

    def index 
        tenants = Tenant.all
        render json: tenants
    end 

    def update 
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant, status: :ok
    end 

    def destroy  
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end 

    private 

    def tenant_params
        params.permit(:name, :age)
    end 

    def render_record_invalid_response(invalid)
        render json: {error: invalid.record.errors.full_messages}
    end 

    def render_record_not_found_response 
        render json: {error: "Tenant not found"}
    end 
end 