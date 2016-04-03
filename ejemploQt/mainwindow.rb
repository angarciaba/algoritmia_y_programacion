
  def lanzarMoneda()
    if rand(2) == 0
      label.text = "CARA"
    else
      label.text = "SELLO"
    end
  end

