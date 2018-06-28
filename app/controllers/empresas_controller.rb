class EmpresasController < ApplicationController
    def new
        @empresa = Empresa.new(params[:empresa])
    
    end

    def create
        @empresa = Empresa.new(params[:empresa])
    
        @empresa.save
        redirect_to root_path
    end

    def show
      
    end
end
