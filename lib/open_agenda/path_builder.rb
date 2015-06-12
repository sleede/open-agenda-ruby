module OpenAgenda
  class PathBuilder
    attr_reader :path, :params

    def initialize(path, params = [])
      @params = params
      @path = path || ''
    end

    def build
      return @built_path if @built_path

      splited_path = decompose_path

      built_path = splited_path.map do |part|
        if part[0] == ':'
          param = params.shift
          if param
            param
          else
            raise StandardError, "Missing path param #{part}"
          end
        else
          part
        end
      end

      @built_path = built_path.join
      @built_path
    end

    def params=(params)
      @params = params
      @built_path = nil
    end

    def decompose_path
      path.split(/(:[a-z_]+)/)
    end
  end
end
