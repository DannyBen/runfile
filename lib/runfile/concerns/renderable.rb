module Runfile
  module Renderable
    include Colsole

    def render(view, context: nil)
      path = "#{base_view_path}/#{view}.gtx"
      GTX.render_file path, context: context, filename: path
    end

  private

    def base_view_path
      @base_view_path ||= ::File.expand_path '../views', __dir__
    end
  end
end
