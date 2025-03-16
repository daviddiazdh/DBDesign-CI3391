import pandas as pd

# Cargar el archivo Excel
df = pd.read_excel("datos_proy2.xlsx", sheet_name=1, engine="openpyxl")  # O usa pd.read_csv("datos.csv")

# Incluye : "Pais de Nacionalidad"

columnas_a_excluir = ["ID", "Tipo", "Documento", "Domicilio","Pais de Domicilio", "Correo Electronico", "Telefono", "Celular", "Fax", "Numero de agente", "Nombre/Razon Social", "Representante legal", "Cedula", "Numero de poder"]  # Lista de columnas a excluir
df = df.drop(columns=columnas_a_excluir)

# Nombre de la tabla
tabla = "bichito"

# Generar sentencias INSERT
sql_script = f"INSERT INTO {tabla} ({', '.join(df.columns)}) VALUES\n"

paises_unicos = set()

values = []
for _, row in df.iterrows():

    pais = row['Pais de Domicilio']
    if pais not in paises_unicos:
        paises_unicos.add(pais)

        row_values = ', '.join(f"'{x}'" if isinstance(x, str) else str(x) for x in row)
        values.append(f"({row_values})")

sql_script += ",\n".join(values) + ";\n"

# Guardar en un archivo .sql
with open("paises_solicitantes.sql", "w", encoding="utf-8") as f:
    f.write(sql_script)

print("Archivo SQL generado correctamente.")