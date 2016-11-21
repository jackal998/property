module ObjsHelper
  def category_params
    params.require(:obj).permit(:category_ids=>[])
  end
  def tpconstruction
    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162"
    raw_data = JSON.parse(RestClient.get(url))
    return raw_data
  end
end
