class Api::V1::SearchController < Api::V1::ApplicationController

  ##
  # Search User, Topic, Post and Feed with given search string.
  #
  # * *Param*     :
  #    - +search_string+:: the search string
  # * *Returns*   :
  #    - json format of search result. The result is groupby
  #      the type (User, Topic, Post, Feed), each type contains 
  #      4 reuslts
  #
  # TODO the sunspot group seems not the way I wanted
  ##
  def search_all
    results_hash = Hash.new
    search = Sunspot.search User, Topic, Post, Feed do
      logger.debug "search time is #{params[:search_string]}"
      fulltext  search_params
      group      :type do
        limit      4 #each type only return top 4 match
      end
    end

    search.group(:type).groups.each do |group|
      type = group.value
      type_results = Hash.new
      group.results.each do |result|
        type_results.store(result.id,result.serializable_hash)
      end
      results_hash.store(type, type_results)
    end
    
    render :json => results_hash.to_json
  end

  ##
  # Search User with given search string.
  #
  # * *Param*     :
  #    - +search_string+:: the search string
  # * *Returns*   :
  #    - json format of search result. 
  ##
  def search_user
    search = Sunspot.search User do
      fulltext search_params
    end
    r = Hash.new
    search.results.each do |u|
      r.store(u.id,u)
    end
    render :json => r.to_json
  end

  private
  # Whitelist the required fields in params hash

  def search_params
    params.require(:search_string)
  end

end
