class CitiesController < ApplicationController
  def index
  end

  def show
    @city_gossips=[]
    Gossip.all.each {|gossip|
      if gossip.user.city_id == params[:id].to_i
      @city_gossips.push(gossip)
      end
    }
  end
end
