require File.expand_path '../spec_helper.rb', __FILE__
require 'ostruct'
require "f1sales_custom/hooks"
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do

  context 'when is from Faceboook' do
    let(:source_name) { 'Facebook - Renault Cannes' }

    let(:source) do
      source = OpenStruct.new
      source.name = source_name
      source
    end

    context 'when does not have store info' do
      let(:store_name) { 'Santa Cruz do Sul' }
      let(:lead) do
        lead = OpenStruct.new
        lead.message = "por_qual_concessionária_você_quer_ser_atendido(a)?: #{store_name}: cidade: Triunfo"
        lead.source = source
        lead
      end

      it 'returns source name with store' do
        expect(described_class.switch_source(lead)).to eq("#{source_name} - #{store_name}")
      end
    end
  end

  context 'when is from Autoforce' do
    let(:source_name) { 'Autoforce' }

    let(:source) do
      source = OpenStruct.new
      source.name = source_name
      source
    end

    context 'when contains store info' do
      let(:store_name) { 'Montenegro' }
      let(:lead) do
        lead = OpenStruct.new
        lead.description = "Cliente HILDA portador do CPF 00908919883 converteu na isca SOLICITAR COTAÇÃO no produto 'CITY 2019 DX' com ENTRADA de R$ 40000 em 12X. Forma de Negociação: 'Estou apenas pesquisando'. Cliente deseja receber contato por: Email e Telefone/WhatsApp. Data da conversão: 19:40. URL da conversão: https://hmotors.com.br/novos/city-2019 Origem: Orgânico    *. Unidade: Montenegro"
        lead.source = source
        lead
      end

      it 'returns source name with store' do
        expect(described_class.switch_source(lead)).to eq("#{source_name} - #{store_name}")
      end
    end
  end
end
