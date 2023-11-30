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
root.title("Route Table DDL Operations")
root.geometry('600x400')  # Set the window size
root.resizable(False, False)  # Disable resizing

# Apply theme and styles
style = ttk.Style(root)
style.theme_use("clam")  # Set a theme for ttk widgets
# Define colors and styles (same as the Locality screen)
bg_color = '#f0f0f0'
button_color = '#333333'
text_color = '#ffffff'
highlight_color = '#5fba7d'
# Apply styles
style.configure('TButton', background=button_color, foreground=text_color)
style.map('TButton', background=[('active', highlight_color)])
style.configure('Treeview', background=bg_color, fieldbackground=bg_color, foreground='black')
style.map('Treeview', background=[('selected', highlight_color)])
style.configure('Vertical.TScrollbar', background=button_color, troughcolor=bg_color)

# Treeview setup
treeview_frame = ttk.Frame(root)
treeview_frame.pack(pady=10, padx=10, fill='both', expand=True)
treeview = ttk.Treeview(treeview_frame, selectmode='browse')
treeview.pack(side='left', fill='both', expand=True)
# Define the columns
treeview['columns'] = ('Route ID', 'Distance', 'Hours')
treeview.column('#0', width=0, stretch=tk.NO)
treeview.column('Route ID', anchor=tk.CENTER, width=80)
treeview.column('Distance', anchor=tk.W, width=180)
treeview.column('Hours', anchor=tk.W, width=100)
# Create headings
treeview.heading('#0', text='', anchor=tk.CENTER)
treeview.heading('Route ID', text='Route ID', anchor=tk.CENTER)
treeview.heading('Distance', text='Distance', anchor=tk.CENTER)
treeview.heading('Hours', text='Hours', anchor=tk.CENTER)
# Scrollbar for the Treeview
scrollbar = ttk.Scrollbar(treeview_frame, orient=tk.VERTICAL, command=treeview.yview)
scrollbar.pack(side='right', fill='y')
treeview.configure(yscrollcommand=scrollbar.set)

# CRUD functions
def refresh_data():
    # Clear the existing data in the Treeview
    for i in treeview.get_children():
        treeview.delete(i)
    # Fetch new data from the Route table and insert it into the Treeview
    try:
        cursor.execute("SELECT * FROM Route")
        rows = cursor.fetchall()
        for row in rows:
            treeview.insert('', 'end', values=row)
    except Exception as e:
        messagebox.showerror("Error", "Failed to fetch data from database") 

def add_route():
    route_id = simpledialog.askstring("Input", "Enter the route ID:")
    distance = simpledialog.askstring("Input", "Enter the distance (in km):")
    hours = simpledialog.askstring("Input", "Enter the duration (in hours):")
    if route_id and distance and hours:
        try:
            cursor.execute("INSERT INTO Route (route_id, distance, hours) VALUES (?, ?, ?)", 
                           (int(route_id), int(distance), int(hours)))
            conn.commit()
            refresh_data()
            messagebox.showinfo("Success", "Route added successfully.")
        except Exception as e:
            messagebox.showerror("Error", "Failed to add route to database. Error: " + str(e))

def update_route():
    selected_item = treeview.selection()
    if selected_item:
        route_id = treeview.item(selected_item[0])['values'][0]
        distance = simpledialog.askstring("Input", "Enter the new distance (in km):", initialvalue=treeview.item(selected_item[0])['values'][1])
        hours = simpledialog.askstring("Input", "Enter the new duration (in hours):", initialvalue=treeview.item(selected_item[0])['values'][2])
        if distance and hours:
            try:
                cursor.execute("UPDATE Route SET distance = ?, hours = ? WHERE route_id = ?", 
                               (int(distance), int(hours), route_id))
                conn.commit()
                refresh_data()
                messagebox.showinfo("Success", "Route updated successfully.")
            except Exception as e:
                messagebox.showerror("Error", "Failed to update route. Error: " + str(e))
    else:
        messagebox.showwarning("Warning", "Please select a route to update.")

def delete_route():
    selected_item = treeview.selection()
    if selected_item:
        route_id = treeview.item(selected_item[0])['values'][0]
        if messagebox.askyesno("Confirm Delete", "Are you sure you want to delete this route?"):
            try:
                cursor.execute("DELETE FROM Route WHERE route_id = ?", (route_id,))
                conn.commit()
                refresh_data()
                messagebox.showinfo("Success", "Route deleted successfully.")
            except Exception as e:
                messagebox.showerror("Error", "Failed to delete route. Error: " + str(e))
    else:
        messagebox.showwarning("Warning", "Please select a route to delete.")


# Initial data load
refresh_data()

# Buttons for CRUD operations
button_frame = ttk.Frame(root)
button_frame.pack(pady=10, fill='x')
add_button = ttk.Button(button_frame, text="Add Route", command=add_route)
update_button = ttk.Button(button_frame, text="Update Selected Route", command=update_route)
delete_button = ttk.Button(button_frame, text="Delete Selected Route", command=delete_route)
add_button.pack(side='left', fill='x', expand=True, padx=2)
update_button.pack(side='left', fill='x', expand=True, padx=2)
delete_button.pack(side='left', fill='x', expand=True, padx=2)

# Start the GUI event loop
root.mainloop()
