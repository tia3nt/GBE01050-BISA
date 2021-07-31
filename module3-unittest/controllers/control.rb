class Control

    def self.getter(className, classVar)
      case classVar
        when "cp_mode"
            className.cp_mode

        when "this_mode"
          className.this_mode

        when "wd"
          className.wd

        when "header"
          className.header

        when "cp_db"
          className.cp_db

        when "getter_number"
          className.getter_number

        end

    end

    def self.setter(className, classVar, classValue)
      case classVar
        when "cp_mode"
            className.set_cp_mode(classValue)

        when "this_mode"
          className.set_this_mode(classValue)

        when "wd"
          className.set_wd(classValue)

        when "header"
          className.set_header(classValue)

        when "cp_db"
          className.set_cp_db(classValue)

        when "getter_number"
          className.set_getter_number(classValue)

        end
    end
end
