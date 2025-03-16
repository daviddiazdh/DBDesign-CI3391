with open("prueba.sql", "rb") as f:
    content = f.read()

# Reemplazar caracteres fuera del rango ASCII (0-127)
fixed_content = bytes(b if b < 128 else ord(' ') for b in content)

with open("insert_marca_fixed.sql", "wb") as f:
    f.write(fixed_content)

print("Archivo corregido guardado como insert_marca_fixed.sql")