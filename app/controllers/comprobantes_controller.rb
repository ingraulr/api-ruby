class ComprobantesController < ApplicationController
    def index
        @comprobantes = Comprobante.all
    end

    def new
        @comprobante = Comprobante.new
    end

    def create
        @comprobante = Comprobante.new(comprobante_params)
        @comprobante.fecha = Time.now
        if @comprobante.save
            redirect_to comprobantes_path
        else
            render 'new'
        end
    end

    def show
        @comprobante = Comprobante.find(params[:id])
    end

    def destroy
        @comprobante = Comprobante.find(params[:id])
        @comprobante.destroy

        redirect_to comprobantes_path
    end

    private

        def comprobante_params
            params.require(:comprobante).permit(:empresa_uid, :empresa_api_key, :ambiente, :objeto, :certificado_pem, :llave_pem, :llave_password, :folio, :fecha, :tipo_comprobante, :lugar_expedicion, :forma_pago, :metodo_pago, :moneda, :tipo_cambio, :subtotal, :total, :rfc_emisor, :nombre_emisor, :regimen_fiscal_emisor, :rfc_receptor, :nombre_receptor, :uso_cfdi, :clave_producto_servicio, :clave_unidad, :cantidad, :descripcion, :valor_unitario, :importe, :unidad, :no_identificacion, :base, :impuesto, :tipo_factor)
        end
end

