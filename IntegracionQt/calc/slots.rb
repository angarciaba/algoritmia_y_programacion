    def sumar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f + operando2LineEdit.text.to_f
    end

    def restar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f - operando2LineEdit.text.to_f
    end

    def multiplicar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f * operando2LineEdit.text.to_f
    end

    def dividir()
      resultadoLineEdit.text = operando1LineEdit.text.to_f / operando2LineEdit.text.to_f
    end

    def resto()
      resultadoLineEdit.text = operando1LineEdit.text.to_f % operando2LineEdit.text.to_f
    end

    def exponenciar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f ** operando2LineEdit.text.to_f
    end

    def terminar()
      qtiDestroy()
    end

