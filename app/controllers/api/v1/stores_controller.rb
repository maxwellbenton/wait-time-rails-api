class Api::V1::StoresController < ApplicationController
    
    def index
        @stores = Store.all.map{|s| {id: s.id, name: s.name, address: s.address}}
        render json: @stores
    end

    def data_search
        distance = 0.5
        @stores = Store.where(latitude: ((params[:location][:latitude]-distance)..(params[:location][:latitude]+distance)), longitude: ((params[:location][:longitude]-distance)..(params[:location][:longitude]+distance)))
        stores = @stores.sort_by{|store| store.wait_times.length}
        render json: stores.as_json(methods:[:total_wait_time, :average_wait_time, :estimated_wait_time])
    end

    def query_search
        #find store by search bar - need to get fuzzy-ish search working
        byebug
    end
    

    def show
        @store = Store.find(params[:store_id][:id])
        render json: @store, include: :wait_times
    end

    def search
        distance = 0.003
        @stores = Store.where(latitude: ((params[:location][:latitude]-distance)..(params[:location][:latitude]+distance)), longitude: ((params[:location][:longitude]-distance)..(params[:location][:longitude]+distance)))
        stores = @stores.sort_by{|store| Math.sqrt((((store.latitude-params[:location][:latitude]).abs)*((store.latitude-params[:location][:latitude]).abs))+(((store.longitude-params[:location][:longitude]).abs)*((store.longitude-params[:location][:longitude]).abs)))}
        byebug stores
        render json: stores.as_json(methods:[:total_wait_time, :average_wait_time, :estimated_wait_time])
    end

     def wide_search
        distance = 0.1
        @stores = Store.where(latitude: ((params[:location][:latitude]-distance)..(params[:location][:latitude]+distance)), longitude: ((params[:location][:longitude]-distance)..(params[:location][:longitude]+distance)))
        stores = @stores.sort_by{|store| Math.sqrt((((store.latitude-params[:location][:latitude]).abs)*((store.latitude-params[:location][:latitude]).abs))+(((store.longitude-params[:location][:longitude]).abs)*((store.longitude-params[:location][:longitude]).abs)))}
        render json: stores.as_json(methods:[:total_wait_time, :average_wait_time, :estimated_wait_time])
    end

    def create
        company = Company.find_or_create_by(name: params[:store][:company])
        store = Store.find_or_create_by(name: params[:store][:name], address: params[:store][:address], company: company)
        if store.save then
            render json: store
        else
            puts 'error'
        end    
    end

\
    
    

    private

    def wait_time_params
        params.require(:location).permit(:latitude, :longitude)
    end
    
    def store_params
        params.require(:store).permit(:name, :address, :company)
    end
end
