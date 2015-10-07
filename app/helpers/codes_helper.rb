module CodesHelper
  def code_set(name)
    Code.where(code: name).take.members
  end
end
