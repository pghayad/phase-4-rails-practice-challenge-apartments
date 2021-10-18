class LeasesController < ApplicationController
    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    private

    def lease_params
        params.permit(:rent)
    end

    def find_lease
        Lease.find(params[:id])
    end
end
