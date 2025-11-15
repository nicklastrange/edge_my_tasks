import { useState } from "react";
import { Search, UserPlus, Users } from "lucide-react";

interface Employee {
  id: string;
  displayName: string;
  position?: string;
  groupNames: string[];
}

export function EmployeeManagementPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedGroup, setSelectedGroup] = useState<string>("all");

  const employees: Employee[] = [
    {
      id: "1",
      displayName: "Jan Kowalski",
      position: "Senior Developer",
      groupNames: ["Dział IT", "Wszyscy pracownicy"],
    },
    {
      id: "2",
      displayName: "Anna Nowak",
      position: "Marketing Manager",
      groupNames: ["Marketing", "Wszyscy pracownicy"],
    },
    {
      id: "3",
      displayName: "Piotr Wiśniewski",
      position: "Sales Representative",
      groupNames: ["Dział sprzedaży", "Wszyscy pracownicy"],
    },
    {
      id: "4",
      displayName: "Maria Dąbrowska",
      position: "HR Specialist",
      groupNames: ["HR", "Wszyscy pracownicy"],
    },
    {
      id: "5",
      displayName: "Tomasz Lewandowski",
      position: "CEO",
      groupNames: ["Zarząd", "Wszyscy pracownicy"],
    },
  ];

  const groups = [
    "all",
    "Wszyscy pracownicy",
    "Dział IT",
    "Dział sprzedaży",
    "Marketing",
    "Zarząd",
    "HR",
  ];

  const filteredEmployees = employees.filter((emp) => {
    const matchesSearch = emp.displayName.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         emp.position?.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesGroup = selectedGroup === "all" || emp.groupNames.includes(selectedGroup);
    return matchesSearch && matchesGroup;
  });

  return (
    <div className="p-8">
      {/* Header */}
      <div className="mb-8">
        <h1 className="text-[#0D1F3A] mb-2">Zarządzanie pracownikami</h1>
        <p className="text-gray-600">Przeglądaj i zarządzaj grupami pracowników</p>
      </div>

      {/* Actions Bar */}
      <div className="bg-white rounded-2xl p-6 shadow-sm mb-6">
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Search */}
          <div className="flex-1 relative">
            <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Szukaj pracownika..."
              className="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-[#1B4E9B] focus:outline-none transition-colors"
            />
          </div>

          {/* Add Employee Button */}
          <button className="bg-[#1B4E9B] hover:bg-[#163d7a] text-white px-6 py-3 rounded-xl transition-colors flex items-center justify-center gap-2 whitespace-nowrap">
            <UserPlus className="w-5 h-5" />
            Dodaj pracownika
          </button>
        </div>

        {/* Group Filter */}
        <div className="mt-4 flex flex-wrap gap-2">
          {groups.map((group) => (
            <button
              key={group}
              onClick={() => setSelectedGroup(group)}
              className={`px-4 py-2 rounded-xl transition-all ${
                selectedGroup === group
                  ? "bg-[#F0A020] text-white shadow-md"
                  : "bg-[#F2F2F2] text-[#0D1F3A] hover:bg-gray-300"
              }`}
            >
              {group === "all" ? "Wszystkie grupy" : group}
            </button>
          ))}
        </div>
      </div>

      {/* Employee List */}
      <div className="bg-white rounded-2xl p-6 shadow-sm">
        <div className="flex items-center justify-between mb-6">
          <h3 className="text-[#0D1F3A]">
            Pracownicy ({filteredEmployees.length})
          </h3>
          <Users className="w-6 h-6 text-[#1B4E9B]" />
        </div>

        <div className="space-y-3">
          {filteredEmployees.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-gray-500">Nie znaleziono pracowników</p>
            </div>
          ) : (
            filteredEmployees.map((employee) => (
              <div
                key={employee.id}
                className="flex flex-col sm:flex-row sm:items-center justify-between p-4 border-2 border-gray-200 rounded-xl hover:border-[#1B4E9B] transition-colors"
              >
                <div className="mb-3 sm:mb-0">
                  <p className="text-[#0D1F3A]">{employee.displayName}</p>
                  {employee.position && (
                    <p className="text-sm text-gray-500 mt-1">{employee.position}</p>
                  )}
                  <div className="flex flex-wrap gap-2 mt-2">
                    {employee.groupNames.map((group) => (
                      <span
                        key={group}
                        className="px-2 py-1 bg-[#1B4E9B]/10 text-[#1B4E9B] rounded-lg text-xs"
                      >
                        {group}
                      </span>
                    ))}
                  </div>
                </div>
                <div className="flex gap-2">
                  <button className="px-4 py-2 border-2 border-[#1B4E9B] text-[#1B4E9B] hover:bg-[#1B4E9B] hover:text-white rounded-xl transition-colors text-sm">
                    Edytuj
                  </button>
                  <button className="px-4 py-2 bg-[#1B4E9B] hover:bg-[#163d7a] text-white rounded-xl transition-colors text-sm">
                    Zobacz zadania
                  </button>
                </div>
              </div>
            ))
          )}
        </div>
      </div>
    </div>
  );
}
