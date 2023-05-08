# Set working directory
setwd("/Volumes/Seagate Exp/Backup_01_04_2017/Octavio/Octavio/VR_project/Manuscripts/Orthoptera_karyotype_evolution/Submission_Evol_letters/new_version/Review_Evolution_2/Figures")

# Read data
Karyotype_and_FN <- read.delim("/Volumes/Seagate Exp/Backup_01_04_2017/Octavio/Octavio/VR_project/Manuscripts/Orthoptera_karyotype_evolution/Submission_Evol_letters/new_version/Review_Evolution_1/Files/Orthoptera_2n_NF.txt", header=TRUE)
View(Karyotype_and_FN)

library("ggplot2")
library("cowplot")  # for 
data = data.frame(Karyotype_and_FN)
mean(data$Male.2n)
median(data$Male.2n)
mean(data$FN)
median(data$FN)

# Plot boxplot
p1 <- ggplot(data, aes(x = Male.2n)) + 
  geom_histogram(binwidth = 1) + 
  theme_classic() +
  ylim(0, 400) +
  labs(title = "", x = "Male 2n", y = "Number of speccies")

p1

# Plot for 2n
p2 <- ggplot(data, aes(x = Family, y = Male.2n)) +
  stat_boxplot(geom = 'errorbar') +
  geom_boxplot(fill='#A4A4A4', color="black", width = 0.5, outlier.shape = 20,
               outlier.size = 1) + 
  coord_flip() +
  theme_classic() +
  #theme(axis.text.y = element_text(hjust = 1, size = 7)) +
  ylim(0,60) +
  labs(title = "", x = "Family", y = "Male 2n") +
  scale_x_discrete(limits=c('Trigonidiidae', 'Mogoplistidae', 'Gryllidae', 'Phalangopsidae',
                            'Schizodactylidae', 'Tettigoniidae', 'Rhaphidophoridae', 'Anostostomatidae',
                            'Gryllacrididae', 'Gryllotalpidae', 'Stenopelmatidae', 'Cylindrachetidae', 'Tridactylidae',
                            'Ripipterygidae', 'Tetrigidae', 'Proscopiidae', 'Epistacidae', 'Eumastacidae',
                            'Morabidae', 'Pyrgomorphidae', 'Pamphagidae', 'Lentulidae', 'Tristiridae',
                            'Acrididae', 'Romaleidae', 'Ommexechidae'))
#theme_minimal()
#geom_boxplot(width = 0.1)
p2

# Plot for FN
p3 <- ggplot(data, aes(x = Family, y = FN)) +
  stat_boxplot(geom = 'errorbar') +
  geom_boxplot(fill='#A4A4A4', color="black", width = 0.5, outlier.shape = 20,
               outlier.size = 1) + 
  coord_flip() +
  theme_classic() +
  ylim(0,60) +
  labs(title = "", x = "Family", y = "Male FN") +
  scale_x_discrete(limits=c('Trigonidiidae', 'Mogoplistidae', 'Gryllidae', 'Phalangopsidae',
                            'Schizodactylidae', 'Tettigoniidae', 'Rhaphidophoridae', 'Anostostomatidae',
                            'Gryllacrididae', 'Gryllotalpidae', 'Stenopelmatidae', 'Cylindrachetidae', 'Tridactylidae',
                            'Ripipterygidae', 'Tetrigidae', 'Proscopiidae', 'Epistacidae', 'Eumastacidae',
                            'Morabidae', 'Pyrgomorphidae', 'Pamphagidae', 'Lentulidae', 'Tristiridae',
                            'Acrididae', 'Romaleidae', 'Ommexechidae'))
p3

# Result
#plot_grid(p1, p2, labels = c("a", "b"), align = "v", ncol = 1)

# Arrange all plot together 
library(patchwork)
#wrap_elements(p1, clip = FALSE) + p2 + p3 + p4 + p5 + p6 + p7 + p8 +
p1 + p2 / p3 +
  #guide_area() + 
  plot_layout(guides = "collect", ncol = 2) +
  plot_annotation(tag_levels = 'a') &
  theme(plot.tag = element_text(face = 'bold'), 
        legend.position = "bottom")

#### Compute Kruskal-Wallis test followed by Dunn post hoc test to calculate 
# pairwise comparisons between clades
library(dplyr)
dat <- data %>%
  select(Family, Male.2n)

summary(data$Male.2n) # stats entire sample
library(doBy) # summarise by group
summaryBy(Male.2n ~ Family,
          data = data,
          FUN = median,
          na.rm = TRUE
)
# boxplot by species
ggplot(data = data) +
  aes(x = Family, y = Male.2n, fill = Family) +
  geom_boxplot() +
  theme(legend.position = "none")

# Kruskal-Wallis test
kruskal.test(Male.2n ~ Family,
             data = data
)
# Perform Dunn post hoc test
library(FSA)
dunnTest(Male.2n ~ Family,
         data = data,
         method = "holm"
)
