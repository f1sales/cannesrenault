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
        lead.description = "Cliente DAVI SOUZA OU CARLA converteu na isca ESTOU INTERESSADO no produto ‘DUSTER OROCH 2022 DYNAMIQUE 2.0 AUTOMÁTICO ’. O cliente permite utilizar os dados enviados. Cliente deseja receber contato por: WhatsApp. Data da conversão: 01/12/2021 14:03. URL da conversão: https://www.cannesrenault.com.br/novos/duster-oroch-2022/dynamique-2-0-automatico Origem: Orgânico. Unidade: Montenegro "
        lead.source = source
        lead
      end

      it 'returns source name with store' do
        expect(described_class.switch_source(lead)).to eq("#{source_name} - #{store_name}")
      end
    end
  end
end
