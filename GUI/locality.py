import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import pypyodbc as odbc

# Database connection parameters
DRIVER_NAME = 'ODBC Driver 17 for SQL Server'
SERVER_NAME = 'Sanal'
DATABASE_NAME = 'CityTramConveyanceManagementSystem'

# Initialize database connection
def get_db_connection():
    connection_string = f"""
        DRIVER={{{DRIVER_NAME}}};
        SERVER={SERVER_NAME};
        DATABASE={DATABASE_NAME};
        Trusted_Connection=yes;
    """
    return odbc.connect(connection_string)

conn = get_db_connection()
cursor = conn.cursor()

# GUI setup
root = tk.Tk()
root.title("Locality Table DDL Operations")
root.geometry('600x400')  # Set the window size
root.resizable(False, False)  # Disable resizing

# Apply theme and styles
style = ttk.Style(root)
style.theme_use("clam")  # Set a theme for ttk widgets

# Define colors and styles
bg_color = '#f0f0f0'
button_color = '#333333'
text_color = '#ffffff'
highlight_color = '#5fba7d'

style.configure('TButton', background=button_color, foreground=text_color)
style.map('TButton', background=[('active', highlight_color)])
style.configure('Treeview', background=bg_color, fieldbackground=bg_color, foreground='black')
style.map('Treeview', background=[('selected', highlight_color)])
style.configure('Vertical.TScrollbar', background=button_color, troughcolor=bg_color)

# Define Treeview to display data with column names
treeview_frame = ttk.Frame(root)
treeview_frame.pack(pady=10, padx=10, fill='both', expand=True)

treeview = ttk.Treeview(treeview_frame, selectmode='browse')
treeview.pack(side='left', fill='both', expand=True)

# Define the columns
treeview['columns'] = ('ID', 'Name', 'Zip Code')
treeview.column('#0', width=0, stretch=tk.NO)  # Hides the default first column
treeview.column('ID', anchor=tk.CENTER, width=80)
treeview.column('Name', anchor=tk.W, width=180)
treeview.column('Zip Code', anchor=tk.W, width=100)

# Create headings
treeview.heading('#0', text='', anchor=tk.CENTER)
treeview.heading('ID', text='ID', anchor=tk.CENTER)
treeview.heading('Name', text='Name', anchor=tk.CENTER)
treeview.heading('Zip Code', text='Zip Code', anchor=tk.CENTER)

# Scrollbar for the Treeview
scrollbar = ttk.Scrollbar(treeview_frame, orient=tk.VERTICAL, command=treeview.yview)
scrollbar.pack(side='right', fill='y')
treeview.configure(yscrollcommand=scrollbar.set)

# Refresh the Treeview data
def refresh_data(cursor, treeview):
    treeview.delete(*treeview.get_children())
    cursor.execute("SELECT * FROM Locality")
    for row in cursor.fetchall():
        treeview.insert('', tk.END, values=row)  # Inserting data row-wise

# Add a new locality
def add_locality(cursor, conn, treeview):
    new_name = simpledialog.askstring("Input", "Enter the locality name:")
    new_zipcode = simpledialog.askstring("Input", "Enter the locality zipcode:")
    
    # Check for the highest current ID and add 1 to it to get a new unique ID
    cursor.execute("SELECT MAX(locality_id) FROM Locality")
    max_id_result = cursor.fetchone()
    # If the table is empty, start IDs from 1, otherwise increment the max ID
    new_id = 1 if max_id_result[0] is None else max_id_result[0] + 1
    
    if new_name and new_zipcode:
        try:
            cursor.execute("INSERT INTO Locality (locality_id, locality_name, locality_zipcode) VALUES (?, ?, ?)", 
                           (new_id, new_name, new_zipcode))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))


# Function to update a locality
def update_locality(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        locality_id = selected_item[0]
        new_name = simpledialog.askstring("Input", "Enter the new locality name:", initialvalue=selected_item[1])
        new_zipcode = simpledialog.askstring("Input", "Enter the new locality zipcode:", initialvalue=selected_item[2])
        if new_name and new_zipcode:
            try:
                cursor.execute("UPDATE Locality SET locality_name = ?, locality_zipcode = ? WHERE locality_id = ?",
                               (new_name, new_zipcode, locality_id))
                conn.commit()
                refresh_data(cursor, treeview)
            except Exception as e:
                messagebox.showerror("Error", str(e))

# Function to delete a locality
def delete_locality(cursor, conn, treeview):
    selected = treeview.selection()
    if selected:
        selected_item = treeview.item(selected[0])['values']
        locality_id = selected_item[0]
        try:
            cursor.execute("DELETE FROM Locality WHERE locality_id = ?", (locality_id,))
            conn.commit()
            refresh_data(cursor, treeview)
        except Exception as e:
            messagebox.showerror("Error", str(e))

# Buttons for CRUD operations
button_frame = ttk.Frame(root)
button_frame.pack(pady=10, fill='x')

add_button = ttk.Button(button_frame, text="Add Locality", command=lambda: add_locality(cursor, conn, treeview))
update_button = ttk.Button(button_frame, text="Update Selected Locality", command=lambda: update_locality(cursor, conn, treeview))
delete_button = ttk.Button(button_frame, text="Delete Selected Locality", command=lambda: delete_locality(cursor, conn, treeview))

add_button.pack(side='left', fill='x', expand=True, padx=2)
update_button.pack(side='left', fill='x', expand=True, padx=2)
delete_button.pack(side='left', fill='x', expand=True, padx=2)

# Initial data load
refresh_data(cursor, treeview)

# Start the GUI event loop
root.mainloop()

