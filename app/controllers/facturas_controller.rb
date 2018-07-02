class FacturasController < ApplicationController
    
    def index
        @facturas = Factura.all

    end
    def new
        @factura = Factura.new
        @empresa = Empresa.new
    end

    def create
        @factura = Factura.new(factura_params)
        @factura.fecha = Time.now
        if @factura.save
            redirect_to facturas_path
        else
            render 'new'
        end
    end
    
    private

    def factura_params
        params.require(:factura).permit(:folio, :fecha, :tipo_comprobante, :lugar_expedicion, :forma_pago, :metodo_pago, :moneda, :tipo_cambio, :subtotal, :total)
    end
end
