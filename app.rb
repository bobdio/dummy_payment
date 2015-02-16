require "sinatra"
require 'rest_client'

class DummyPayment < Sinatra::Base
  enable :sessions

  get '/' do
    "Hi, on Dummy Paymet Service)"
  end

  post '/payment' do
    @params =  params
    session[:token] = params[:token]
    session[:order_no] = params[:order][:order_no]
    session[:back_url] = params[:order][:back_url]

    erb :payment
  end

  post '/check' do
    @status = (rand * 10).floor == 5 ? 'reject' : 'paid'
    @token = session[:token]
    @back_url = session[:back_url]
    @order_no = session[:order_no]

    erb :check
  end
end