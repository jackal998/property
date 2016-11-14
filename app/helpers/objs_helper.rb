module ObjsHelper
  def category_params
    params.require(:obj).permit(:category_ids=>[])
  end
end
