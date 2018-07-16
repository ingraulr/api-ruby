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
        certificados_path

        @comprobante.certificado_pem = @cert.contenido_certificado(@path_certificado)
        @comprobante.llave_pem = @cert.contenido_llave(@path_llave)
        @comprobante.llave_password = @cert.password_llave(@path_password)
        @comprobante.fecha = Time.now
        @comprobante.generado = false
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
        variables
        certificados_path

        json = '{"meta":{"empresa_uid":"3fed8484f9","empresa_api_key":"i-8blpV-OAcUVRDAVf2yGw","ambiente":"","objeto":"factura"},"data":[{"datos_fiscales":{"certificado_pem":"","llave_pem":"","llave_password":""},"cfdi":{"cfdi__comprobante":{"folio":"123","fecha":"2018-03-25T12:12:12","tipo_comprobante":"I","lugar_expedicion":"21100","forma_pago":"01","metodo_pago":"PUE","moneda":"MXN","tipo_cambio":"1","subtotal":"99.00","total":"99.00","cfdi__emisor":{"rfc":"DDM090629R13","nombre":"Emisor Test","regimen_fiscal":"601"},"cfdi__receptor":{"rfc":"XEXX010101000","nombre":"Receptor Test","uso_cfdi":"G01"},"cfdi__conceptos":{"cfdi__concepto":[{"clave_producto_servicio":"01010101","clave_unidad":"KGM","cantidad":"1","descripcion":"descripcion test","valor_unitario":"99.00","importe":"99.00","unidad":"unidad","no_identificacion":"KGM123","cfdi__impuestos":{"cfdi__traslados":{"cfdi__traslado":[{"base":"99.00","impuesto":"002","tipo_factor":"Exento"}]}}}]}}}}]}';
        factura = JSON.parse(json)
        factura["data"][0]["datos_fiscales"]["certificado_pem"] = @comprobante.certificado_pem
        factura["data"][0]["datos_fiscales"]["llave_pem"]       = @cert.contenido_llave(@path_llave)
        factura["data"][0]["datos_fiscales"]["llave_password"]  = @cert.password_llave(@path_password)
        factura["data"][0]["cfdi"]["cfdi__comprobante"]["fecha"] = Time.now.strftime("%FT%T")
        factura_generada = @api.generacion_factura(factura)
        factura_generada
        
        if  factura_generada.has_key?("error")
            flash[:danger] = "Error al timbrar la factura el servidor regreso el siguiente error:" + factura_generada.to_s + "revisa el json conchatumadre"
        else
            @comprobante.generado = true
            @comprobante.save!
            flash[:success] = "Comprobante Timbrado con Exito, UUID:" + @uuid.to_s + " ."
            redirect_to comprobantes_path
        end

        
    end

    def cancelar
        variables
        certificados_path

        json = '{"meta":{"empresa_uid":"3fed8484f9","empresa_api_key":"i-8blpV-OAcUVRDAVf2yGw","ambiente":"S","objeto":"factura"},"data":[{"rfc":"","uuid":[""],"datos_fiscales":{"certificado_pem":"","llave_pem":"","password_llave":""},"acuse": false}]}';
        cancelacion = JSON.parse(json)
        factura_uuid = @comprobante.uuid
        cancelacion["data"][0]["rfc"] = @comprobante.rfc_emisor
        cancelacion["data"][0]["uuid"][0] = factura_uuid
        cancelacion["data"][0]["datos_fiscales"]["certificado_pem"] = @comprobante.certificado_pem
        cancelacion["data"][0]["datos_fiscales"]["llave_pem"]       = @cert.contenido_llave(@path_llave)
        cancelacion["data"][0]["datos_fiscales"]["llave_password"]  = @cert.password_llave(@path_password)
        factura_cancelada = @api.cancelacion_factura(cancelacion)
        
        if factura_cancelada["data"][0]["descripcion"].present?
            @comprobante.vigencia = true
            @comprobante.save!
            flash[:success] = "Comprobante Cancelado con Exito..!"
            redirect_to comprobantes_path
        else
            
        end

    end
    
    def enviar
        variables
        json = '{"meta":{"empresa_uid":"3fed8484f9","empresa_api_key":"i-8blpV-OAcUVRDAVf2yGw","ambiente":"S","objeto":"factura"},"data":[{"uuid":[""],"destinatarios":[{"correo":"contacto@docdigitales.com"}],"titulo":"Envio de Factura: 123","texto":"Envio de Factura Desde la API: Raul","pdf":"true"}]}';
        factura_uuid = @comprobante.uuid
        envio = JSON.parse(json)

        envio["data"][0]["uuid"][0] = factura_uuid
        factura_enviada = @api.envio_factura(envio)
    end

    def descargar
        variables
        json = '{"meta":{"empresa_uid":"3fed8484f9","empresa_api_key":"i-8blpV-OAcUVRDAVf2yGw","ambiente":"S","objeto":"factura"},"data":[{"uuid":[""],"destinatarios":[{"correo":"sandbox@docdigitales.com"}],"titulo":"Descargar factura","texto":"Adjunto factura generada","pdf":"true"}]}';
        uuid = "CA8E6F94-91A8-409E-B45A-8B628B02FBF8";
        descarga = JSON.parse(json)
        # Establecer parametros de envio
        descarga["data"][0]["uuid"][0] = uuid
        # Descargar
        factura_descargada = @api.descargar_factura(descarga)
        factura_descargada["data"][0]["link"].to_s = link
        link
        if factura_descargada["data"][0]["link"].present?
            flash[:success] = "factura descargada con exito"
            redirect_to link
        end
    end
    

    def variables
        @comprobante = Comprobante.find(params[:comprobante_id])
        @api  = Factura.new
        @cert = Certificado.new
    end

    def certificados_path
        @path_certificado = '/home/raul/api/prueba-api/certificados/certificado.cer'
        @path_llave = '/home/raul/api/prueba-api/certificados/llave.pem'
        @path_password = '/home/raul/api/prueba-api/certificados/password.txt'
    end
    private

        def comprobante_params
            params.require(:comprobante).permit(:empresa_uid, :empresa_api_key, :ambiente, :objeto, :certificado_pem, :llave_pem, :llave_password, :folio, :fecha, :tipo_comprobante, :lugar_expedicion, :forma_pago, :metodo_pago, :moneda, :tipo_cambio, :subtotal, :total, :rfc_emisor, :nombre_emisor, :regimen_fiscal_emisor, :rfc_receptor, :nombre_receptor, :uso_cfdi, :clave_producto_servicio, :clave_unidad, :cantidad, :descripcion, :valor_unitario, :importe, :unidad, :no_identificacion, :base, :impuesto, :tipo_factor)
        end
end

