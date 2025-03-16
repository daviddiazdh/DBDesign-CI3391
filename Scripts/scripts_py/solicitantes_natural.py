import pandas as pd

# Cargar el archivo Excel
df = pd.read_excel("datos_proy2.xlsx", sheet_name=1, engine="openpyxl")  # O usa pd.read_csv("datos.csv")

columnas_a_excluir = ["Documento", "Domicilio", "Pais de Domicilio", "Correo Electronico", "Telefono", "Celular", "Fax", "Pais de Nacionalidad", "Representante legal", "Cedula", "Numero de poder", "Numero de agente"]  # Lista de columnas a excluir
df = df.drop(columns=columnas_a_excluir)

# Nombre de la tabla
tabla = "bichito"

# Generar sentencias INSERT
sql_script = f"INSERT INTO {tabla} ({', '.join(df.columns)}) VALUES\n"

values = []
for _, row in df.iterrows():
    flag = False
    for col, x in zip(df.columns, row):
        if col == "Tipo" and x == "Persona Natural":
            flag = True
    if flag:
        row_values = ', '.join(f"'{x}'" if isinstance(x, str) else str(x) for x in row)
        values.append(f"({row_values})")

sql_script += ",\n".join(values) + ";\n"

# Guardar en un archivo .sql
with open("insert_solicitante_natural.sql", "w", encoding="utf-8") as f:
    f.write(sql_script)

print("Archivo SQL generado correctamente.")