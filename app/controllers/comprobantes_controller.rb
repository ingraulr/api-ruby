class ComprobantesController < ApplicationController
    def index
        @comprobantes = Comprobante.all
    end

    def new
        @comprobante = Comprobante.new
    end

    def create
        @comprobante = Comprobante.new(comprobante_params)
        @api  = Factura.new
        @cert = Certificado.new
        @path_certificado = '/home/raul/api/prueba-api/certificados/certificado.cer'
        @path_llave = '/home/raul/api/prueba-api/certificados/llave.pem'
        @path_password = '/home/raul/api/prueba-api/certificados/password.txt'

        @comprobante.certificado_pem = @cert.contenido_certificado(@path_certificado)
        @comprobante.llave_pem = @cert.contenido_llave(@path_llave)
        @comprobante.llave_password = @cert.password_llave(@path_password)
        @comprobante.fecha = Time.now
        if @comprobante.save
            flash[:success] = "Comprobante Guardado Correctamente"
            redirect_to comprobante_path(@comprobante)
        else
            flash[:danger] = "Error al Crear Comprobante"
            render 'new'
        end
    end

    def show
        @comprobante = Comprobante.find(params[:id])
    end

    def destroy
        @comprobante = Comprobante.find(params[:id])
        if @comprobante.destroy
            flash[:danger] = "Comprobante eliminado con Exito"
            redirect_to comprobantes_path
        end
    end

    def timbrar
        @comprobante = Comprobante.find(params[:comprobante_id])
        @api  = Factura.new
        @cert = Certificado.new
        @path_certificado = '/home/raul/api/prueba-api/certificados/certificado.cer'

        @path_llave = '/home/raul/api/prueba-api/certificados/llave.pem'
        @path_password = '/home/raul/api/prueba-api/certificados/password.txt'
        json = '{"meta":{"empresa_uid":"","empresa_api_key":"","ambiente":"","objeto":""},"data":[{"datos_fiscales":{"certificado_pem":"","llave_pem":"","llave_password":""},"cfdi":{"cfdi__comprobante":{"folio":"","fecha":"","tipo_comprobante":"","lugar_expedicion":"","forma_pago":"","metodo_pago":"","moneda":"","tipo_cambio":"","subtotal":"","total":"","cfdi__emisor":{"rfc":"","nombre":"","regimen_fiscal":""},"cfdi__receptor":{"rfc":"","nombre":"","uso_cfdi":""},"cfdi__conceptos":{"cfdi__concepto":[{"clave_producto_servicio":"","clave_unidad":"","cantidad":"","descripcion":"","valor_unitario":"","importe":"","unidad":"","no_identificacion":"","cfdi__impuestos":{"cfdi__traslados":
                    {"cfdi__traslado":[{"base":"","impuesto":"","tipo_factor":""}]}}}]}}}}]}';
        factura = JSON.parse(json)
            factura["meta"]["empresa_uid"] = @comprobante.empresa_uid
            factura["meta"]["empresa_api_key"] = @comprobante.empresa_api_key
            factura["meta"]["ambiente"] = @comprobante.ambiente
            factura["meta"]["objeto"] = @comprobante.objeto
            factura["data"][0]["datos_fiscales"]["certificado_pem"] = @cert.contenido_certificado(@path_certificado)
            factura["data"][0]["datos_fiscales"]["llave_pem"]       = @cert.contenido_llave(@path_llave)
            factura["data"][0]["datos_fiscales"]["llave_password"]  = @cert.password_llave(@path_password)
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["folio"] = @comprobante.folio
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["fecha"] = @comprobante.fecha
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["tipo_comprobante"] = @comprobante.tipo_comprobante
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["lugar_expedicion"] = @comprobante.lugar_expedicion
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["forma_pago"] = @comprobante.forma_pago
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["metodo_pago"] = @comprobante.metodo_pago
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["moneda"] = @comprobante.moneda
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["tipo_cambio"] = @comprobante.tipo_cambio
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["subtotal"] = @comprobante.subtotal
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["total"] = @comprobante.total
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__emisor"]["rfc"] = @comprobante.rfc_emisor
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__emisor"]["nombre"] = @comprobante.nombre_emisor
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__emisor"]["regimen_fiscal"] = @comprobante.regimen_fiscal_emisor
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__receptor"]["rfc"] = @comprobante.rfc_receptor
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__receptor"]["nombre"] = @comprobante.nombre_receptor
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__receptor"]["uso_cfdi"] = @comprobante.uso_cfdi
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["clave_producto_servicio"] = @comprobante.clave_producto_servicio
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["clave_unidad"]  = @comprobante.clave_unidad
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["cantidad"] =  @comprobante.cantidad
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["descripcion"] = @comprobante.descripcion
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["valor_unitario"] = @comprobante.valor_unitario
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["importe"] = @comprobante.unidad
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["no_identificacion"] = @comprobante.no_identificacion
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["cfdi__impuestos"]["cfdi__traslados"]["cfdi__traslado"][0]["base"] = @comprobante.base
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["cfdi__impuestos"]["cfdi__traslados"]["cfdi__traslado"][0]["impuesto"] = @comprobante.impuesto
            factura["data"][0]["cfdi"]["cfdi__comprobante"]["cfdi__conceptos"]["cfdi__concepto"][0]["cfdi__impuestos"]["cfdi__traslados"]["cfdi__traslado"][0]["tipo_factor"] = @comprobante.tipo_factor
            
        
        factura_generada = @api.generacion_factura(factura.to_json)
        debugger
        puts 'algo'

    end
    private

        def comprobante_params
            params.require(:comprobante).permit(:empresa_uid, :empresa_api_key, :ambiente, :objeto, :certificado_pem, :llave_pem, :llave_password, :folio, :fecha, :tipo_comprobante, :lugar_expedicion, :forma_pago, :metodo_pago, :moneda, :tipo_cambio, :subtotal, :total, :rfc_emisor, :nombre_emisor, :regimen_fiscal_emisor, :rfc_receptor, :nombre_receptor, :uso_cfdi, :clave_producto_servicio, :clave_unidad, :cantidad, :descripcion, :valor_unitario, :importe, :unidad, :no_identificacion, :base, :impuesto, :tipo_factor)
        end
end

