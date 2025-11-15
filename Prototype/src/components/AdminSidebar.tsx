import { LayoutDashboard, CheckSquare, Users, BarChart3 } from "lucide-react";

interface AdminSidebarProps {
  activePage: string;
  onPageChange: (page: string) => void;
}

export function AdminSidebar({ activePage, onPageChange }: AdminSidebarProps) {
  const menuItems = [
    { id: "dashboard", label: "Dashboard", icon: LayoutDashboard },
    { id: "events", label: "Wydarzenia", icon: CheckSquare },
    { id: "employees", label: "Pracownicy", icon: Users },
    { id: "statistics", label: "Statystyki", icon: BarChart3 },
  ];

  return (
    <div className="w-64 bg-[#0D1F3A] min-h-screen p-6 hidden lg:block">
      <div className="mb-8">
        <h2 className="text-white">Moje Zadania</h2>
        <p className="text-sm text-gray-400 mt-1">Admin Panel</p>
      </div>
      
      <nav className="space-y-2">
        {menuItems.map((item) => {
          const Icon = item.icon;
          const isActive = activePage === item.id;
          
          return (
            <button
              key={item.id}
              onClick={() => onPageChange(item.id)}
              className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${
                isActive
                  ? "bg-[#1B4E9B] text-white shadow-lg"
                  : "text-gray-300 hover:bg-[#1B4E9B]/50 hover:text-white"
              }`}
            >
              <Icon className="w-5 h-5" />
              <span>{item.label}</span>
            </button>
          );
        })}
      </nav>
    </div>
  );
}