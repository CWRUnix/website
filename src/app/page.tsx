import Link from "next/link";

const mockUrls = [
	"https://github.com/CWRUnix/marketing/blob/main/assets/CWRU_Linux_Club_with%20text_tdfs.png?raw=true",
];

const mockImages = mockUrls.map((url, index) => ({
	id: index + 1,
	url,
}));

export default function HomePage() {
	return (
		<main className="">
			<div className="flex flex-wrap gap-4">
				{[...mockImages, ...mockImages, ...mockImages].map((image) => (
					<div key={image.id} className="w-48">
						<img src={image.url} alt="mock" />
					</div>
				))}
			</div>
		</main>
	);
}
