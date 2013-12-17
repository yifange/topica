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
  ##
  def search_all
    results_hash = Hash.new
    search = Sunspot.search User, Topic, Post, Feed do
      fulltext   params[:search_string]
      group      :type do
        limit      4 #each type only return top 4 match
      end
    end

    seach.group(:type).groups.each do |group|
      type = group.value
      type_results = Hash.new
      group.results.each do |result|
        type_results.store(result.id,result.serializable_hash)
      end
      results_hash.store(type, type_results)
    end
    
    render :json => results_hash.to_json
  end
end
