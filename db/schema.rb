# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_12_201141) do

  create_table "catalogo_ambientes", force: :cascade do |t|
    t.string "ambiente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogo_monedas", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogo_objetos", force: :cascade do |t|
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogo_unidads", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clave_sats", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comprobantes", force: :cascade do |t|
    t.string "empresa_uid"
    t.string "empresa_api_key"
    t.string "ambiente"
    t.string "objeto"
    t.string "certificado_pem"
    t.string "llave_pem"
    t.string "llave_password"
    t.string "folio"
    t.datetime "fecha"
    t.string "tipo_comprobante"
    t.string "lugar_expedicion"
    t.string "forma_pago"
    t.string "metodo_pago"
    t.string "moneda"
    t.string "tipo_cambio"
    t.integer "subtotal"
    t.integer "total"
    t.string "rfc_emisor"
    t.string "nombre_emisor"
    t.string "regimen_fiscal_emisor"
    t.string "rfc_receptor"
    t.string "nombre_receptor"
    t.string "uso_cfdi"
    t.string "clave_producto_servicio"
    t.string "clave_unidad"
    t.integer "cantidad"
    t.text "descripcion"
    t.integer "valor_unitario"
    t.integer "importe"
    t.string "unidad"
    t.string "no_identificacion"
    t.integer "base"
    t.string "impuesto"
    t.string "tipo_factor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "timbrado"
    t.boolean "generado"
    t.boolean "vigencia"
    t.string "uuid"
  end

  create_table "empresas", force: :cascade do |t|
    t.string "empresa_uid"
    t.string "empresa_api_key"
    t.string "ambiente"
    t.string "objeto"
    t.string "certificado_pem"
    t.string "llave_pem"
    t.string "llave_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forma_pagos", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metodo_pagos", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regimen_fiscals", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uso_cfdis", force: :cascade do |t|
    t.string "clave"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
