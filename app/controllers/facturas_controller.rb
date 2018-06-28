class FacturasController < ApplicationController
    def new
      @factura = Factura.new
    end


end 
