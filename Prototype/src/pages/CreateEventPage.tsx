import { useState } from "react";
import { ArrowLeft, Plus } from "lucide-react";

interface Category {
  name: string;
  requiredField: boolean;
  notificationPolicy?: string;
}

export function CreateEventPage({ onBack }: { onBack: () => void }) {
  const [formData, setFormData] = useState({
    title: "",
    description: "",
    categoryName: "HR",
    groups: [] as string[],
    deadline: "",
    priority: 2,
  });

  const categories: Category[] = [
    { name: "HR", requiredField: true, notificationPolicy: "24h,3h" },
    { name: "Obowiązkowe", requiredField: true, notificationPolicy: "24h,3h,1h" },
    { name: "Rozrywka", requiredField: false, notificationPolicy: "24h" },
    { name: "Finanse", requiredField: true, notificationPolicy: "24h,3h" },
  ];

  const availableGroups = [
    "Wszyscy pracownicy",
    "Dział IT",
    "Dział sprzedaży",
    "Marketing",
    "Zarząd",
    "Produkcja",
  ];

  const handleGroupToggle = (group: string) => {
    setFormData((prev) => ({
      ...prev,
      groups: prev.groups.includes(group)
        ? prev.groups.filter((g) => g !== group)
        : [...prev.groups, group],
    }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const selectedCategory = categories.find((c) => c.name === formData.categoryName);
    alert(
      `Wydarzenie zostało utworzone!\n\nTytuł: ${formData.title}\nKategoria: ${formData.categoryName}\nObowiązkowe: ${selectedCategory?.requiredField ? "Tak" : "Nie"}\nGrupy: ${formData.groups.join(", ")}`
    );
    onBack();
  };

  const selectedCategory = categories.find((c) => c.name === formData.categoryName);

  return (
    <div className="p-8">
      {/* Header */}
      <div className="flex items-center gap-4 mb-8">
        <button
          onClick={onBack}
          className="p-2 hover:bg-[#F2F2F2] rounded-lg transition-colors"
        >
          <ArrowLeft className="w-6 h-6 text-[#0D1F3A]" />
        </button>
        <div>
          <h1 className="text-[#0D1F3A]">Utwórz nowe wydarzenie</h1>
          <p className="text-gray-600 mt-1">Wydarzenia generują zadania dla wybranych grup</p>
        </div>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="max-w-3xl">
        <div className="space-y-6">
          {/* Title */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">Tytuł wydarzenia</label>
            <input
              type="text"
              value={formData.title}
              onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              placeholder="np. Szkolenie BHP Q4"
              className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-[#1B4E9B] focus:outline-none transition-colors"
              required
            />
          </div>

          {/* Description */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">Opis wydarzenia</label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              placeholder="Dodaj szczegóły wydarzenia..."
              rows={4}
              className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-[#1B4E9B] focus:outline-none transition-colors resize-none"
            />
          </div>

          {/* Category Selection */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">Kategoria</label>
            <div className="grid grid-cols-2 gap-3 mb-4">
              {categories.map((category) => (
                <button
                  key={category.name}
                  type="button"
                  onClick={() => setFormData({ ...formData, categoryName: category.name })}
                  className={`p-4 rounded-xl transition-all text-left ${
                    formData.categoryName === category.name
                      ? "bg-[#1B4E9B] text-white shadow-md"
                      : "bg-[#F2F2F2] text-[#0D1F3A] hover:bg-gray-300"
                  }`}
                >
                  <div className="flex items-center justify-between mb-2">
                    <span>{category.name}</span>
                    {category.requiredField && (
                      <span className="text-xs bg-[#F0A020] text-white px-2 py-1 rounded-full">
                        Obowiązkowe
                      </span>
                    )}
                  </div>
                  <p className="text-xs opacity-70">
                    Przypomnienia: {category.notificationPolicy}
                  </p>
                </button>
              ))}
            </div>
            
            {selectedCategory && (
              <div className="mt-4 p-4 bg-[#1B4E9B]/10 rounded-xl">
                <p className="text-sm text-[#0D1F3A]">
                  <strong>Polityka powiadomień:</strong> {selectedCategory.notificationPolicy}
                </p>
                {selectedCategory.requiredField && (
                  <p className="text-sm text-[#F0A020] mt-2">
                    ⚠️ To zadanie jest obowiązkowe - pracownicy nie mogą go odrzucić
                  </p>
                )}
              </div>
            )}
          </div>

          {/* Deadline */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">Termin wykonania</label>
            <input
              type="datetime-local"
              value={formData.deadline}
              onChange={(e) => setFormData({ ...formData, deadline: e.target.value })}
              className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:border-[#1B4E9B] focus:outline-none transition-colors"
              required
            />
          </div>

          {/* Groups */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">
              Przypisz do grup ({formData.groups.length} wybrano)
            </label>
            <div className="space-y-2">
              {availableGroups.map((group) => (
                <button
                  key={group}
                  type="button"
                  onClick={() => handleGroupToggle(group)}
                  className={`w-full text-left px-4 py-3 rounded-xl transition-all ${
                    formData.groups.includes(group)
                      ? "bg-[#1B4E9B]/10 border-2 border-[#1B4E9B]"
                      : "border-2 border-gray-200 hover:border-[#1B4E9B]/50"
                  }`}
                >
                  <div className="flex items-center justify-between">
                    <span className="text-[#0D1F3A]">{group}</span>
                    {formData.groups.includes(group) && (
                      <div className="w-5 h-5 bg-[#F0A020] rounded-full flex items-center justify-center">
                        <Plus className="w-3 h-3 text-white rotate-45" />
                      </div>
                    )}
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* Priority Slider */}
          <div className="bg-white rounded-2xl p-6 shadow-sm">
            <label className="block text-[#0D1F3A] mb-3">
              Priorytet: {["Niski", "Średni", "Wysoki"][formData.priority]}
            </label>
            <input
              type="range"
              min="0"
              max="2"
              value={formData.priority}
              onChange={(e) => setFormData({ ...formData, priority: parseInt(e.target.value) })}
              className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
              style={{
                background: `linear-gradient(to right, #1B4E9B 0%, #1B4E9B ${
                  (formData.priority / 2) * 100
                }%, #E5E7EB ${(formData.priority / 2) * 100}%, #E5E7EB 100%)`,
              }}
            />
            <div className="flex justify-between mt-2 text-sm text-gray-500">
              <span>Niski</span>
              <span>Średni</span>
              <span>Wysoki</span>
            </div>
          </div>

          {/* Submit Button */}
          <button
            type="submit"
            className="w-full bg-[#1B4E9B] hover:bg-[#163d7a] text-white py-4 rounded-xl transition-colors shadow-lg"
          >
            Utwórz wydarzenie i wygeneruj zadania
          </button>
        </div>
      </form>
    </div>
  );
}
