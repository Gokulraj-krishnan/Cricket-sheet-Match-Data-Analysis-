{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "118c4ca6-f4df-4203-9c9c-a9822730977a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "✅ Database connection ready: C:\\Users\\LENOVO\\OneDrive\\Desktop\\Cricsheet - Analysis\\database\\cricket.db\n",
      "Loading IPL_deliveries.csv  →  table: IPL_deliveries\n",
      "Loading IPL_matches.csv  →  table: IPL_matches\n",
      "Loading ODI_deliveries.csv  →  table: ODI_deliveries\n",
      "Loading ODI_matches.csv  →  table: ODI_matches\n",
      "Loading T20_deliveries.csv  →  table: T20_deliveries\n",
      "Loading T20_matches.csv  →  table: T20_matches\n",
      "Loading Test_deliveries.csv  →  table: Test_deliveries\n",
      "Loading Test_matches.csv  →  table: Test_matches\n",
      "\n",
      "🎉 ALL TABLES CREATED SUCCESSFULLY!\n"
     ]
    }
   ],
   "source": [
    "import os\n",
    "import pandas as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "# 1) Paths\n",
    "data_processed = r\"C:\\Users\\LENOVO\\OneDrive\\Desktop\\Cricsheet - Analysis\\data_processed\"\n",
    "db_path = r\"C:\\Users\\LENOVO\\OneDrive\\Desktop\\Cricsheet - Analysis\\database\\cricket.db\"\n",
    "\n",
    "# 2) Create DB engine\n",
    "engine = create_engine(f\"sqlite:///{db_path}\")\n",
    "\n",
    "print(\"✅ Database connection ready:\", db_path)\n",
    "\n",
    "# 3) Load each CSV into a table\n",
    "for file in os.listdir(data_processed):\n",
    "    if not file.endswith(\".csv\"):\n",
    "        continue\n",
    "\n",
    "    csv_path = os.path.join(data_processed, file)\n",
    "    table_name = file.replace(\".csv\", \"\")\n",
    "\n",
    "    print(f\"Loading {file}  →  table: {table_name}\")\n",
    "\n",
    "    # Force match_id as string (important for joins)\n",
    "    df = pd.read_csv(csv_path, dtype={\"match_id\": str}, low_memory=False)\n",
    "\n",
    "    df.to_sql(table_name, con=engine, if_exists=\"replace\", index=False)\n",
    "\n",
    "print(\"\\n🎉 ALL TABLES CREATED SUCCESSFULLY!\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "69b62b40-a9c5-46e6-9209-815f3adced25",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.13.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
