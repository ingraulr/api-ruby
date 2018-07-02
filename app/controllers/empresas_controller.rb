class EmpresasController < ApplicationController
    def index
        @empresas = Empresa.all
    end

    def new
        @empresa = Empresa.new
    end

    def create
        @empresa = Empresa.new(empresa_params)
    
        if @empresa.save
            redirect_to empresas_path
        else
            render 'new'
        end
    end

    def show
        @empresa = Empresa.find(params[:id])
    end

    def destroy
        @empresa = Empresa.find(params[:id])
        @empresa.destroy

        redirect_to empresas_path
    end

    private

        def empresa_params
            params.require(:empresa).permit(:empresa_uid, :empresa_api_key, :ambiente, :objeto, :certificado_pem ,:llave_pem ,:llave_password)
        end
end
