import { useState } from "react";
import { EmployeeHome } from "./pages/EmployeeHome";
import { PreferencesPage } from "./pages/PreferencesPage";
import { AdminDashboard } from "./pages/AdminDashboard";
import { CreateEventPage } from "./pages/CreateEventPage";
import { StatisticsPage } from "./pages/StatisticsPage";
import { EmployeeManagementPage } from "./pages/EmployeeManagementPage";
import { AdminSidebar } from "./components/AdminSidebar";
import { Settings, LayoutDashboard } from "lucide-react";

type View = "employee" | "admin";
type Page = "home" | "preferences" | "dashboard" | "events" | "employees" | "statistics";

export default function App() {
  const [view, setView] = useState<View>("employee");
  const [page, setPage] = useState<Page>("home");

  const renderContent = () => {
    if (view === "employee") {
      if (page === "preferences") {
        return <PreferencesPage onBack={() => setPage("home")} />;
      }
      return <EmployeeHome />;
    }

    // Admin view
    if (page === "events") {
      return <CreateEventPage onBack={() => setPage("dashboard")} />;
    }
    if (page === "employees") {
      return <EmployeeManagementPage />;
    }
    if (page === "statistics") {
      return <StatisticsPage />;
    }
    return <AdminDashboard />;
  };

  return (
    <div className="flex min-h-screen bg-[#F2F2F2]">
      {/* View Switcher - Fixed Position */}
      <div className="fixed top-4 left-4 z-50 flex gap-2 bg-white rounded-2xl p-2 shadow-lg">
        <button
          onClick={() => {
            setView("employee");
            setPage("home");
          }}
          className={`flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${
            view === "employee"
              ? "bg-[#1B4E9B] text-white"
              : "text-[#0D1F3A] hover:bg-[#F2F2F2]"
          }`}
        >
          <Settings className="w-4 h-4" />
          <span className="hidden sm:inline">Employee</span>
        </button>
        <button
          onClick={() => {
            setView("admin");
            setPage("dashboard");
          }}
          className={`flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${
            view === "admin"
              ? "bg-[#1B4E9B] text-white"
              : "text-[#0D1F3A] hover:bg-[#F2F2F2]"
          }`}
        >
          <LayoutDashboard className="w-4 h-4" />
          <span className="hidden sm:inline">Admin</span>
        </button>
      </div>

      {/* Admin Sidebar */}
      {view === "admin" && (
        <AdminSidebar
          activePage={page}
          onPageChange={(newPage) => setPage(newPage as Page)}
        />
      )}

      {/* Main Content */}
      <div className="flex-1">
        {view === "employee" && page === "home" && (
          <div className="fixed bottom-4 right-4 z-50">
            <button
              onClick={() => setPage("preferences")}
              className="bg-[#F0A020] hover:bg-[#d89018] text-white p-4 rounded-full shadow-2xl transition-all hover:scale-110"
            >
              <Settings className="w-6 h-6" />
            </button>
          </div>
        )}
        {renderContent()}
      </div>
    </div>
  );
}