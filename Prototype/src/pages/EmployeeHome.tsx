import { useState } from "react";
import { Bell } from "lucide-react";
import { TaskTabs } from "../components/TaskTabs";
import { FilterChips } from "../components/FilterChips";
import { TaskCard } from "../components/TaskCard";
import { NotificationBadge } from "../components/NotificationBadge";
import { NotificationPreview } from "../components/NotificationPreview";

interface Task {
  id: string;
  status: string;
  actionUrl?: string;
  employeeId: string;
  createdAt: Date;
  deadline: Date;
  eventTitle: string;
  categoryName: string;
}

export function EmployeeHome() {
  const [activeTab, setActiveTab] = useState<"todo" | "done">("todo");
  const [activeFilters, setActiveFilters] = useState<string[]>([]);
  const [notificationCount, setNotificationCount] = useState(3);
  const [showNotification, setShowNotification] = useState(false);
  
  const [tasks, setTasks] = useState<Task[]>([
    {
      id: "1",
      status: "pending",
      employeeId: "emp1",
      eventTitle: "Faktura do rozliczenia",
      categoryName: "Finanse",
      deadline: new Date(Date.now() + 3 * 60 * 60 * 1000), // 3 hours from now
      createdAt: new Date(Date.now() - 24 * 60 * 60 * 1000),
      actionUrl: "https://example.com/invoice",
    },
    {
      id: "2",
      status: "pending",
      employeeId: "emp1",
      eventTitle: "Szkolenie BHP",
      categoryName: "Obowiązkowe",
      deadline: new Date(Date.now() + 18 * 60 * 60 * 1000), // 18 hours from now
      createdAt: new Date(Date.now() - 48 * 60 * 60 * 1000),
    },
    {
      id: "3",
      status: "pending",
      employeeId: "emp1",
      eventTitle: "Zapisy na piknik firmowy",
      categoryName: "Rozrywka",
      deadline: new Date(Date.now() + 72 * 60 * 60 * 1000), // 72 hours from now
      createdAt: new Date(Date.now() - 12 * 60 * 60 * 1000),
    },
    {
      id: "4",
      status: "pending",
      employeeId: "emp1",
      eventTitle: "Rozliczenie delegacji",
      categoryName: "Finanse",
      deadline: new Date(Date.now() + 4 * 60 * 60 * 1000), // 4 hours from now
      createdAt: new Date(Date.now() - 36 * 60 * 60 * 1000),
    },
  ]);

  const filters = ["HR", "Obowiązkowe", "Rozrywka", "Finanse"];

  const handleFilterToggle = (filter: string) => {
    setActiveFilters((prev) =>
      prev.includes(filter) ? prev.filter((f) => f !== filter) : [...prev, filter]
    );
  };

  const handlePrimaryAction = (id: string) => {
    setTasks((prev) =>
      prev.map((task) => (task.id === id ? { ...task, status: "completed" } : task))
    );
  };

  const handleSecondaryAction = (id: string) => {
    setTasks((prev) =>
      prev.map((task) => (task.id === id ? { ...task, status: "rejected" } : task))
    );
  };

  const filteredTasks = tasks.filter((task) => {
    if (activeTab === "todo" && task.status !== "pending") return false;
    if (activeTab === "done" && task.status === "pending") return false;
    if (activeFilters.length > 0 && !activeFilters.includes(task.categoryName)) return false;
    return true;
  });

  const todoCount = tasks.filter((t) => t.status === "pending").length;
  const doneCount = tasks.filter((t) => t.status !== "pending").length;

  return (
    <div className="min-h-screen bg-[#F2F2F2]">
      {/* Top Bar */}
      <div className="bg-white shadow-sm sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <h1 className="text-[#0D1F3A]">Moje Zadania</h1>
            <button
              onClick={() => setShowNotification(true)}
              className="relative p-2 hover:bg-[#F2F2F2] rounded-lg transition-colors"
            >
              <Bell className="w-6 h-6 text-[#0D1F3A]" />
              {notificationCount > 0 && (
                <div className="absolute -top-1 -right-1 bg-[#F0A020] text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                  {notificationCount}
                </div>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="space-y-6">
          {/* Tabs */}
          <TaskTabs
            activeTab={activeTab}
            onTabChange={setActiveTab}
            todoCount={todoCount}
            doneCount={doneCount}
          />

          {/* Filters */}
          <FilterChips
            filters={filters}
            activeFilters={activeFilters}
            onFilterToggle={handleFilterToggle}
          />

          {/* Task List */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {filteredTasks.length === 0 ? (
              <div className="col-span-full text-center py-12">
                <p className="text-gray-500">
                  {activeTab === "todo" ? "Brak zadań do wykonania" : "Brak wykonanych zadań"}
                </p>
              </div>
            ) : (
              filteredTasks.map((task) => (
                <TaskCard
                  key={task.id}
                  {...task}
                  onPrimaryAction={handlePrimaryAction}
                  onSecondaryAction={handleSecondaryAction}
                />
              ))
            )}
          </div>
        </div>
      </div>

      {/* Notification Preview */}
      <NotificationPreview
        title="Przypomnienie z Eosic"
        body="Zadanie 'Rozliczenie delegacji' wygasa za 3 godziny."
        ctaText="Wykonaj teraz"
        onCta={() => {
          setShowNotification(false);
          setNotificationCount((prev) => Math.max(0, prev - 1));
        }}
        onDismiss={() => setShowNotification(false)}
        isVisible={showNotification}
      />
    </div>
  );
}