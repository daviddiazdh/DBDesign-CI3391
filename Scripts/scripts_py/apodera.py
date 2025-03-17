import pandas as pd

# Cargar el archivo Excel
df = pd.read_excel("datos_proy2.xlsx", sheet_name=1, engine="openpyxl")  # O usa pd.read_csv("datos.csv")

# Incluye : "ID", "Numero de agente", "Numero de poder"

columnas_a_excluir = ["Nombre/Razon Social", "Representante legal", "Tipo", "Documento", "Domicilio", "Pais de Domicilio", "Pais de Nacionalidad", "Correo Electronico", "Telefono", "Celular", "Fax", "Cedula"]  # Lista de columnas a excluir
df = df.drop(columns=columnas_a_excluir)

# Nombre de la tabla
tabla = "bichito"

# Generar sentencias INSERT
sql_script = f"INSERT INTO {tabla} ({', '.join(df.columns)}) VALUES\n"

values = []
for _, row in df.iterrows():
    """
    for col, x in zip(df.columns, row):  # Iteramos sobre cada columna y su valor
        if col == "Fecha" and pd.notna(x): # Si la columna es "nombre", modificar el valor
            x = x.strftime("%Y-%m-%d")
    """
    row_values = ', '.join(f"'{x}'" if isinstance(x, str) else str(x) for x in row)
    values.append(f"({row_values})")

sql_script += ",\n".join(values) + ";\n"

# Guardar en un archivo .sql
with open("insert_apodera.sql", "w", encoding="utf-8") as f:
    f.write(sql_script)

print("Archivo SQL generado correctamente.")