class ProductsValidator {
  String validadeImages(List images) {
    if (images.isEmpty)
      return "Adicione imagens do produto";
    else
      return null;
  }

  String validateTitle(String text) {
    if (text.isEmpty)
      return "Preencha o titulo do produto";
    else
      return null;
  }

  String validateDescription(String text) {
    if (text.isEmpty) return "Preencha a descrição do produto";
    return null;
  }

  String validadePrice(String text) {
    double price = double.tryParse(text);
    if (price != null) {
      if (!text.contains(".") || text.split(".")[1].length != 2) {
        return "Utilize duas casas decimais";
      }
    } else {
      return "Preço inválido";
    }
    return null;
  }
}
