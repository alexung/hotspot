class DocsController < ApplicationController

  def show
    @doc = Doc.find(params[:id])
  end

end
